

/*
IO_Out main(State &state, IO_In io_in) {
	IO_Out io_out;

	io_out.adc_pwm_en = ((state.cnt.slc<3>(8)) == 0);
	io_out.adc_pwm = state.cnt[15];

	if(!io_out.adc_pwm_en) {
		if(state.last_fb != io_in.adc_fb) {
			state.dbg_reg = ~state.dbg_reg;
		}
	} else {
		state.dbg_reg = 0;
	}

	io_out.dbg_en = state.dbg_reg;

//	io_out.led = (state.cnt.slc<4>(20) == 0);

	state.last_fb = io_in.adc_fb;
	++state.cnt;
	return io_out;
}

*/

// TODO: 16 bit
int newton_div10(int x, int &rem) {
	int m=0;
	#pragma hls_unroll yes
	for(int steps=0;steps<20;++steps) {
//		const int x1 = ((x>=0) ? m : (m-1)) * 10;
//		const int x2 = ((x>=0) ? (m+1) : m) * 10;
		int x1 = ((x>=0) ? m : (m-1));
		int x2 = ((x>=0) ? (m+1) : m);

		// *10
		x1 = (x1 << 3) + (x1 << 1);
		x2 = (x2 << 3) + (x2 << 1);

		if((x >= x1) && (x < x2)) {
			rem = x - x1;
			return m;
		}

		// /8 is close enough to *10
		const int chg = (x-x1) >> 3;
		m += chg;
	}
	return 0;
}

/*
// TODO: Templates
void reverse_nibbles(sai16 x) {

	x.set_slc(0, x.slc<4>(12-0));
}
*/

enum StateName {
	State_Wait=0,
	State_TX=1,
	State_TX_Number=2
};

void print(State &state, IO_Out &io_out, uai64 word) {
	const uai10 shifter_default = 0b1000000000;

	const int B115200 = 104;
	if(state.state == State_Wait) {
		++state.cnt;
		if(state.cnt[23]) {
			state.state = State_TX;
			state.cnt = B115200;
			state.bitcnt = 9;
			state.char_idx = ~0;
		}
	} else if((state.state == State_TX) || (state.state == State_TX_Number)) {
		if(state.cnt == B115200) {
			state.cnt = 0;

			if(state.bitcnt == 9) {
				if(state.char_idx == 8) {
					state.state = State_Wait;
					state.cnt = 0;
				} else {
					state.shifter = shifter_default;
					uai8 c = word.slc<8>(uai6(state.char_idx) * 8);
					if(state.state==State_TX){
						if(c=='%') {
							state.state=State_TX_Number;
							state.number = 0xABC;
//							reverse_nibbles(state.number);
						}
						++state.char_idx;
					}

					if(state.state == State_TX_Number) {
						const uai4 nib = state.number.slc<4>(0);
						if(nib < 10) {
							c = '0' + nib;
						} else {
							c = 'A' + (nib-10);
						}
						state.number >>= 4;

						if(state.number == 0) {
							state.state=State_TX;
						}
					}
					state.shifter.set_slc(1, c);
					state.bitcnt=0;
				}
			} else {
				++state.bitcnt;
				state.shifter >>= 1;
			}
		} else {
			++state.cnt;
		}
	}
	io_out.TX = state.shifter[0];
}

IO_Out main(State &state, IO_In io_in) {
	IO_Out io_out;

	print(state, io_out, "HELLO %\n");
//	print(state, io_out, "HELLO a\n");

	io_out.dbg_en = io_out.TX;
	io_out.led = state.state == State_Wait;

	return io_out;
}
