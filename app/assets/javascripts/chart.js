var renderGraph = function(results){

  $(function () {

    var times = results.times;
    $('#container').highcharts({
      chart:{
        type: "column"
      },
      title: {
        text: 'Bike Thefts By Hour',
        x: -20 //center
      },
      subtitle: {
        text: 'Source: data.seattle.gov',
        x: -20
      },
      xAxis: {
        title: {
          text: 'Time of Day'
        },
        categories: ["12AM", "1AM","2AM","3AM","4AM","5AM","6AM","7AM","8AM","9AM","10AM","11AM",
        "12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM", "12PM"]
      },
      yAxis: {
        title: {
          text: 'Number Of Crimes',
          y: 0
        },
        plotLines: [{
          value: 0,
          width: 1,
          color: '#808080'
        }]
      },
      tooltip: {
        animation: true,
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
      },
      series: [{
        name: 'Crime',
        data: [
          times["12am"] || 0,
          times["1am"]  || 0,
          times["2am"]  || 0,
          times["3am"]  || 0,
          times["4am"]  || 0,
          times["5am"]  || 0,
          times["6am"]  || 0,
          times["7am"]  || 0,
          times["8am"]  || 0,
          times["9am"]  || 0,
          times["10am"] || 0,
          times["11am"] || 0,
          times["12am"] || 0,
          times["1pm"]  || 0,
          times["2pm"]  || 0,
          times["3pm"]  || 0,
          times["4pm"]  || 0,
          times["5pm"]  || 0,
          times["6pm"]  || 0,
          times["7pm"]  || 0,
          times["8pm"]  || 0,
          times["8pm"]  || 0,
          times["10pm"] || 0,
          times["11pm"] || 0,
          times["12pm"] || 0
        ]
      }]
    });
  });
};
