import { Controller } from "@hotwired/stimulus"
import Drawflow from 'drawflow'

// Connects to data-controller="roadmap-connector"
export default class extends Controller {

  connect() {
    fetch(window.location.href, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    }})
    .then(response => response.json())
    .then(response => {
      console.log(response)
      const items = {
        "drawflow": {
        "Home": {
          "data": response.data.attributes.steps
        }}}

        console.log(items)

        var id = document.getElementById("drawflow");
        const editor = new Drawflow(id);
    
        editor.reroute = true;
        editor.reroute_fix_curvature = true;
        editor.force_first_input = true;
    
        editor.start();
        editor.import(items)
    
        // editor.zoom_max = 1;
        // editor.zoom_min = 1;
        // editor.zoom_value = 1;

    }) 
  }
}

// {
//   "drawflow": {
//     "Home": {
//       "data": [
//         {
//           "id": 1,
//           "name": "job1",
//           "data": {},
//           "class": "",
//           "html": "<a href='https://google.com'>Helo there Hi lorem</a>",
//           "typenode": false,
//           "inputs": {},
//           "outputs": [
//               {
//               "connections": [
//                 {
//                   "node": "2",
//                   "output": "input_1"
//                 }
//               ]
//             }
//           ],
//           "pos_x": 65,
//           "pos_y": 175
//         },
//         {
//           "id": 2,
//           "name": "job2",
//           "data": {},
//           "class": "",
//           "html": "<div>job2</div>",
//           "typenode": false,
//           "inputs": [
//              {
//               "connections": [
//                 {
//                   "node": "1",
//                   "input": "output_1"
//                 }
//               ]
//             }
//           ],
//           "outputs": {},
//           "pos_x": 65,
//           "pos_y": 300
//         }
//       ]
//     }
//   }
// }


// fetch(window.location.href, {
//   method: 'GET',
//   headers: {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json'
// }})
// .then(response => response.json())
// .then( response => {



