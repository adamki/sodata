var renderGraph = function(results){

  $(function () {
    var times = results.times;
    $('#container').highcharts({
      title: {
        text: 'The Best bike Data',
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
        "12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM"]
      },
      yAxis: {
        title: {
          text: 'Number of Crimes'
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
          times["12AM"] || 0,
          times["1AM"]  || 0,
          times["2AM"]  || 0,
          times["3AM"]  || 0,
          times["4AM"]  || 0,
          times["5AM"]  || 0,
          times["6AM"]  || 0,
          times["7AM"]  || 0,
          times["8AM"]  || 0,
          times["9AM"]  || 0,
          times["10AM"] || 0,
          times["11AM"] || 0,
          times["12AM"] || 0,
          times["1PM"]  || 0,
          times["2PM"]  || 0,
          times["3PM"]  || 0,
          times["4PM"]  || 0,
          times["5PM"]  || 0,
          times["6PM"]  || 0,
          times["7PM"]  || 0,
          times["8PM"]  || 0,
          times["8PM"]  || 0,
          times["10PM"] || 0,
          times["11PM"] || 0,
          times["12PM"] || 0
        ]
      }]
    });
  });
};
