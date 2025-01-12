import { Controller } from "@hotwired/stimulus"
import {Chart,registerables} from 'chart.js';
// Connects to data-controller="dashboard"
Chart.register(...registerables)
export default class extends Controller {
  static values={completed: Object,signups: Object}
  connect() {
    console.log("Chart controller connected");
  }
  initialize() {
    const data=Object.values(this.completedValue)
    const labels=Object.keys(this.completedValue)
    const ctx=document.getElementById("chart")
    console.log(ctx)
    new Chart(ctx,{
      type:'line',
      data:{
        labels:labels,
        datasets:[{
          label:"lesson completed",
          data:data,
          borderWidth: 3,
          fill:true,
          backgroundColor:"#f0d1d5"
        }]
      },
      options:{
        plugins:{
          legend:{
            display:off
          }
        },
        borderColor:"#e23e57",
        scale:{
          x:{
            grid:{
              display:false
            }
          },
          y:{
            grid:{
              borderColor:"#e23e57",
            },
            border:{
              dash:[5,5]
            },
            beginAtZero:true
          },
        }
      }
    })
  }

  static values={completed:Object,signups:Object}
  initialize() {
    const data1=Object.values(this.signupsValue)
    const labels1=Object.keys(this.signupsValue)
    const ctx1=document.getElementById("sign_ups_chart")
    new Chart(ctx1,{
      type:'line',
      data:{
        labels:labels1,
        datasets:[{
          label:"lesson completed",
          data:data1,
          borderWidth: 3,
          fill:true,
          backgroundColor:"#f0d1d5"
        }]
      },
      options:{
        plugins:{
          legend:{
            display:off
          }
        },
        borderColor:"#e23e57",
        scale:{
          x:{
            grid:{
              display:false
            }
          },
          y:{
            grid:{
              borderColor:"#e23e57",
            },
            border:{
              dash:[5,5]
            },
            beginAtZero:true
          },
        }
      }
    })
  }
}
