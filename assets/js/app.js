// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

let start = 0;
let stop = 0;


function start_timer(){

  let task_id = $(".start_button").data('task-id');
  var startts = new Date();
  start = startts.toJSON()
  console.log(start);
  $(".start_button").attr("disabled", "disabled");
  $(".stop_button").removeAttr("disabled");

}

function stop_timer(){
  let task_id = $(".stop_button").data('task-id');
  console.log(task_id);
  var stopts = new Date();
  stop = stopts.toJSON()
  console.log(stop);
  let text = JSON.stringify(
    {
      timeblock: {
        endtime: stop,
        starttime: start,
        task_id: task_id
      }
    }
  );

  $.ajax(timeblock_path,{
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: console.log("timeblock added successfully")
  });

  // $(".start_button").each((_, btn) => {
  //   let target_id = $(btn).data('task-id');
  //   if (target_id == task_id){
  //     $(btn).removeAttr("disabled");
  //   }
  //
  // });
  //
  //
  // $(".stop_button").each((_, btn) => {
  //   let target_id = $(btn).data('task-id');
  //   if (target_id == task_id){
  //     $(btn).attr("disabled", "disabled");
  //   }
  //
  // });
  $(".start_button").removeAttr("disabled");
  $(".stop_button").attr("disabled", "disabled");

}

function init_timeblock(){
  if (!$(".start_button") || !$(".stop_button")) {
    return;
  }
  $(".start_button").click(start_timer);
  $(".stop_button").attr("disabled", "disabled");
  $(".stop_button").click(stop_timer);

  //update_start_button();
}

$(init_timeblock);


// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
