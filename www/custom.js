$(function() {
/*

  // example 1
  document.getElementById("mydiv").onclick = function() {
    var number = Math.random();
    Shiny.onInputChange("mydata", number);
    // $("#toggle").html("Hide Panel");
  };
  
  // example 2
  Shiny.addCustomMessageHandler("myCallbackHandler",
    function(color) {
      document.getElementById("mydiv").style.backgroundColor = color;
    }
  );

  // example 3
  $("button#directory").on("click", function(){
    
    if ($("#columnCharts").length > 0) {
      var htmlLength = $("#columnCharts").html().length;
      console.log(htmlLength);
      if (htmlLength > 0) {
        
        element = document.getElementById("plot1");
       
          Shiny.unbindAll(element);
           element.remove();
          Shiny.bindAll(element);
      }
    } 
  });
  


  # Write bottom line in server.R
  # session$sendCustomMessage(type = "doEmptyChartOptionsWraper", input$chartTypes)
  
  
  Shiny.addCustomMessageHandler("doEmptyChartOptionsWraper",
    function(chartType) {
      console.log(chartType);
      if (chartType == "Pie Chart") {
        $('#xColumnsControls').html("");
        $('#missingSelectColumn').html("");
        $('#xlabelsControls').html("");
        $('#chartOptionsWraper .horizontalRow').html("");
        $('#yColumnsControls').html("");
      } else if (chartType == "Bar Chart") {
        $('#allColumns').html("");
      }
    }
  );
  
  */

  // main body
  $('#submitControls').on('click', '#submit', function() {
    
    
  
    // data chunk
  /* if ($('#toggleDataChunk').html() == "Hide data chunk") {
     console.log("Hide data chunk");
     if($('#dataChunk').attr("style") == "display: none;") {
      
      $('#dataChunk').show();
       $('#toggleDataChunk').html("Hide data chunk");
     } else {
       $('#dataChunk').hide();
       $('#toggleDataChunk').html("Show data chunk");
     }
   } else {
     console.log("Show data chunk");
      if($('#dataChunk').attr("style") != "display: none;") {
        $('#dataChunk').hide();
        $('#toggleDataChunk').html("Show data chunk");
     }
   }*/
   
   // column charts
   if ($('#columnChartsHeading').html() !== "") {
     if ($('#toggleColumnsCharts').html() == "Hide Columns Charts") {
       console.log("Hide Column Charts");
       if($('#columnCharts').attr("style") == "display: none;") {
        
         $('#columnCharts').show();
         $('#toggleColumnsCharts').html("Hide Columns Charts");
       }
        
     } else {
       console.log("Show Column Charts");
        if($('#columnCharts').attr("style") != "display: none;") {
          $('#columnCharts').hide();
          $('#toggleColumnsCharts').html("Show Columns Charts");
       } else {
          $('#columnCharts').show();
          $('#toggleColumnsCharts').html("Hide Columns Charts");
       }
     }
     $('#columnChartsHeading').show();
   }
   
   // answers Wraper
   if ($('#questionsAnswersHeading').html() !== "") {
     if ($('#toggleAnswerOfQuestion').html() == "Hide All Ans") {
       console.log("Hide All Q/A");
       if($('#answersWraper').attr("style") == "display: none;") {
        
         $('#answersWraper').show();
         $('#toggleAnswerOfQuestion').html("Hide All Ans");
       } else {
         $('#answersWraper').hide();
          $('#toggleAnswerOfQuestion').html("Show All Ans");
       }
        
     } else {
       console.log("Show All Q/A");
        if($('#answersWraper').attr("style") != "display: none;") {
          $('#answersWraper').hide();
          $('#toggleAnswerOfQuestion').html("Show All Ans");
       }
       
       /*else {
          $('#answersWraper').show();
          $('#toggleColumnsCharts').html("Hide All Ans");
       }*/
     }
   }
   
  });
  
  
  $('#questionsWraper').on('click', '#q1Submit', function() {
    
    if ($('#dataChunk').html() !== "") {
      $('#dataChunk').hide();
      $('#toggleDataChunk').html("Show data chunk");
    }
    
    if ($('#columnCharts').html() !== "") {
      $('#columnCharts').hide();
      $('#toggleColumnsCharts').html("Show Columns Charts");
    }
    $('#answersWraper').show();
    $('#q1Ans').show();
    $('#toggleAnswerOfQuestion1').html("Hide Ans.1");
    $('#q2Ans').hide();
    $('#toggleAnswerOfQuestion3').html("Show Ans.2");
    $('#q3Ans').hide();
    $('#toggleAnswerOfQuestion3').html("Show Ans.3");
  }); 
  
  $('#questionsWraper').on('click', '#q2Submit', function() {
    
    if ($('#dataChunk').html() !== "") {
      $('#dataChunk').hide();
      $('#toggleDataChunk').html("Show data chunk");
    }
    
    if ($('#columnCharts').html() !== "") {
      $('#columnCharts').hide();
      $('#toggleColumnsCharts').html("Show Columns Charts");
    }
    $('#answersWraper').show();
    $('#q1Ans').hide();
    $('#toggleAnswerOfQuestion1').html("Show Ans.1");
    $('#q2Ans').show();
    $('#toggleAnswerOfQuestion2').html("Hide Ans.2");
    $('#q3Ans').hide();
    $('#toggleAnswerOfQuestion3').html("Show Ans.3");
  });
  
  $('#questionsWraper').on('click', '#q3Submit', function() {
    
    if ($('#dataChunk').html() !== "") {
      $('#dataChunk').hide();
      $('#toggleDataChunk').html("Show data chunk");
    }
    
    if ($('#columnCharts').html() !== "") {
      $('#columnCharts').hide();
      $('#toggleColumnsCharts').html("Show Columns Charts");
    }
    $('#answersWraper').show();
    $('#q1Ans').hide();
    $('#toggleAnswerOfQuestion1').html("Show Ans.1");
    $('#q2Ans').hide();
    $('#toggleAnswerOfQuestion2').html("Show Ans.2");
    $('#q3Ans').show();
    $('#toggleAnswerOfQuestion3').html("Hide Ans.3");
  });
  
  
  $('#dataChunkHeading').on('click', '#toggleDataChunk', function() {
  
   if ($(this).html() == "Hide Profiles") {
      $( '#dataChunk' ).hide();
      $(this).html("Show Profiles");
   }
   else {
      $( '#dataChunk' ).show();
      $(this).html("Hide Profiles");
   }
  });
  
  
  $('#columnChartsHeading').on('click', '#toggleColumnsCharts', function() {
  
   if ($(this).html() == "Hide Columns Charts") {
      $('#columnCharts').hide();
      $(this).html("Show Columns Charts");
   }
   else {
      $('#columnCharts').show();
      $(this).html("Hide Columns Charts");
   }
  });
  
  $('#questionsAnswersHeading').on('click', '#toggleAnswerOfQuestion', function() {
  
   if ($(this).html() == "Hide All Ans") {
      $( '#answersWraper' ).hide();
      $(this).html("Show All Ans");
   }
   else {
      $( '#answersWraper' ).show();
      $(this).html("Hide All Ans");
   }
  });
  
  $('#answersWraper').on('click', '#toggleAnswerOfQuestion1', function() {
  
   if ($(this).html() == "Hide Ans.1") {
      $( '#q1Ans' ).hide();
      $(this).html("Show Ans.1");
   }
   else {
      $( '#q1Ans' ).show();
      $(this).html("Hide Ans.1");
   }
  });
  
  $('#answersWraper').on('click', '#toggleAnswerOfQuestion2', function() {
  
   if ($(this).html() == "Hide Ans.2") {
      $( '#q2Ans' ).hide();
      $(this).html("Show Ans.2");
   }
   else {
      $( '#q2Ans' ).show();
      $(this).html("Hide Ans.2");
   }
  });
  
  $('#answersWraper').on('click', '#toggleAnswerOfQuestion3', function() {
  
   if ($(this).html() == "Hide Ans.3") {
      $( '#q3Ans' ).hide();
      $(this).html("Show Ans.3");
   }
   else {
      $( '#q3Ans' ).show();
      $(this).html("Hide Ans.3");
   }
  });
  
  // sidebar
  $('#drawChartHeading').on('click', '#drawChartHeadingText', function() {
  
   $('#questionsWraper').slideUp();
   $('#DrawChartFiltersWraper').slideDown();
   $('#DrawChartFiltersWraper').attr('style', 'background-color: #FFFFFF;');
   // $('#columnCharts').show();
  });
  
  $('#askQuestionsHeading').on('click', '#askQuestionsHeadingText', function() {
  
   $('#DrawChartFiltersWraper').slideUp();
   $('#questionsWraper').slideDown();
   $('#questionsWraper').attr('style', 'background-color: #FFFFFF;');
  });
  
  /*$('#toggleDataChunk').click(function(){
    $( '#dataChunk' ).toggle();
  });*/
  
  // hide dynamically added elements
  /*$("#questionsWraper").on("mouseenter","div",function(e){

      $('#q2Form').hide();
  });*/
  
  $('#questionsWraper').on('click', '#q1', function() {
  
   $('#formQ1').slideDown();
   $('#formQ2').slideUp();
   $('#formQ3').slideUp();
  });
  
  $('#questionsWraper').on('click', '#q2', function() {
  
   $('#formQ1').slideUp();
   $('#formQ2').slideDown();
   $('#formQ3').slideUp();
  });
  
  $('#questionsWraper').on('click', '#q3', function() {
  
   $('#formQ1').slideUp();
   $('#formQ2').slideUp();
   $('#formQ3').slideDown();
  });
  
  
});
