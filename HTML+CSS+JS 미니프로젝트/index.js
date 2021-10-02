let target = document.querySelector("#dynamic");
function randomString(){
    let stringArr = ["Learn to HTML","Learn to CSS","Learn to Js"];
    let selectSrting = stringArr[Math.floor(Math.random() * stringArr.length)];
    let selectSrtingArr = selectSrting.split("");

    return selectSrtingArr;
}

//타이핑 리셋
function resetTyping(){
    target.textContent = "";
    dynamic(randomString());
}

//한글자씩 텍스트 출력 함수
function dynamic(randomArr){
    console.log(randomArr);
    if(randomArr.length > 0){
        target.textContent += randomArr.shift();
        setTimeout(function(){
            dynamic(randomArr);
        }, 80);
    }else{
        setTimeout(resetTyping, 3000);
    }
}
dynamic(randomString());
console.log(selectSrting);
console.log(selectSrtingArr);
//커서 깜빡임 효과
function blink(){
    target.classList.toggle("active");
}
setInterval(blink, 500);