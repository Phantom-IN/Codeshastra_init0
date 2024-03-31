let exportBtn = document.getElementById('btnExport');
exportBtn.onclick = exportToExcel;
function exportToExcel() {
    var wb = XLSX.utils.table_to_book(document.getElementById('rankTable'), { sheet: "Sheet JS" });
    return XLSX.writeFile(wb, 'Interviews.xlsx');
}
window.onload = async function () {
    let body = document.querySelector('tbody');
    let users = await getScores();
    users.sort((a, b) => (b.totalScore - a.totalScore))
    users.forEach((element, index) => {
        console.log(element.name + ': ' + element.email + ': ' + element.totalScore)
        let tr = document.createElement('tr');
        tr.innerHTML = `
        <th scope="row">${index + 1}</th>
        <td>${element.name}</td>
        <td>${element.email}</td>
        <td>${element.totalScore}</td>`
        body.appendChild(tr);
    });
    let joinNowBtn = document.querySelector(".join-us-btn");
    let user = JSON.parse(localStorage.getItem('user'));

    let loc = "../login/loginSignup.html";
    console.log('xxx', user);
    if (user) {
        loc = "../UserProfile/userProfile.html";
        joinNowBtn.textContent = 'Profile'
    }
    joinNowBtn.addEventListener('click', function () {
        location.href = loc;
    })
}