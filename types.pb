hls_types {
  name: "IO_In"
  hls_type {
    as_struct {
      fields {
        name: "adc_fb"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
    }
  }
}
hls_types {
  name: "IO_Out"
  hls_type {
    as_struct {
      fields {
        name: "adc_pwm"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "adc_pwm_en"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "dbg_en"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "led"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "TX"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "MOTORLB"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "MOTORLF"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "MOTORRB"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "MOTORRF"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
    }
  }
}
hls_types {
  name: "State"
  hls_type {
    as_struct {
      fields {
        name: "cnt"
        hls_type {
          as_int {
            signed: false
            width: 32
          }
        }
      }
      fields {
        name: "last_fb"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "dbg_reg"
        hls_type {
          as_int {
            signed: false
            width: 1
          }
        }
      }
      fields {
        name: "shifter"
        hls_type {
          as_int {
            signed: false
            width: 10
          }
        }
      }
      fields {
        name: "bitcnt"
        hls_type {
          as_int {
            signed: false
            width: 4
          }
        }
      }
      fields {
        name: "char_idx"
        hls_type {
          as_int {
            signed: false
            width: 8
          }
        }
      }
      fields {
        name: "state"
        hls_type {
          as_int {
            signed: false
            width: 3
          }
        }
      }
      fields {
        name: "number"
        hls_type {
          as_int {
            signed: true
            width: 16
          }
        }
      }
    }
  }
}
