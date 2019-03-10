var tableData = data;
var tbody = d3.select("tbody");

console.log(data);

tbody.enter().append('tr')
    Object.entries(data).forEach(([key, value]) => {
      var cell = tbody.append('td');
      cell.text(value);
    });

////////////////

var filter = d3.select("#filter-btn");

filter.on("click", function() {
    d3.event.preventDefault();
    var inputElement = d3.select("#datetime");
    var inputValue = inputElement.property("value");

    console.log(inputValue);

    var filteredData = tableData.filter(date => date.datetime === inputValue);

    console.log(filteredData);

    filteredData.forEach((sighting) => {
      var row = tbody.append("tr");
      Object.entries(sighting).forEach(([key, value]) => {
        var cell = tbody.append("td");
        cell.text(value);

    });
  });
});