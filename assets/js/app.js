// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$(document).ready(function() {
  const axios = require("axios");

  axios({
    method: "get",
    url: "/api/tickets",
    responseType: "json"
  }).then(function(response) {
    var apiresponse = response.data;

    var resultArray = [];

    for (let i = 0; i <= apiresponse.length - 1; i++) {
      resultArray.push([
        "<a href=/tickets/" +
          apiresponse[i].id +
          ">" +
          apiresponse[i].ref_no +
          "</a>",
        apiresponse[i].subject,
        apiresponse[i].email,
        apiresponse[i].assignee,
        "<span id='status'>" + apiresponse[i].status + "</span>",
        apiresponse[i].inserted_at.substr(0, 10)
      ]);
    }

    var table = $("#body")
      .DataTable({
        responsive: true,
        data: resultArray,
        pagingType: "simple",
        dom: '<"top"fip>rt<"clear">',
        language: { search: "" },
        pageLength: 15,
        columnDefs: [{ className: "", targets: "_all" }]
      })
      .columns.adjust()
      .responsive.recalc();

    $(".dataTables_filter input").attr("placeholder", "Search");
    $.fn.DataTable.ext.pager.numbers_length = 4;

    $(".previous").html("");
    $(".next").html("");
    // $(".previous").addClass("icon icon-arrow-left");
    // $(".next").addClass("icon icon-arrow-right");
    $("#body_previous").addClass("btn");
    $("#body_next").addClass("btn");
    $("#body_info").text(function(index, text) {
      return text
        .replace("Showing", "Viewing")
        .replace("to", "-")
        .replace("entries", "");
    });
    $("#body_filter")
      .after("<button class='dyn dyn-btn2 btn'><b>New Ticket</b></button>")
      .after("<button class='dyn dyn-btn1 btn'>All Types</button>");
    $("#total").text(resultArray.length);
    $(".dyn-btn2").click(function() {
      window.location.href = "/tickets/new";
    });
  });
});
