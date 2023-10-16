// const sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay))

document.onreadystatechange=function () {
    if (document.readyState=="complete"){
        loadingFade();
    }
}

function startLoading() {
    const position = document.getElementById('loading');
    var loadingBackground=document.getElementById('Calc-loading_bg');
    position.style.display = 'block';
    loadingBackground.style.opacity=1;
    setTimeout(() => loadingFade(), 30000)
}

function loadingFade() {
    var opacity=1;
    const position = document.getElementById('loading');
    var loadingBackground=document.getElementById('Calc-loading_bg');
    var time=setInterval(function () {
        if (opacity<=0){
            clearInterval(time);
            position.style.display = 'none';
            try{
                translate.listener.start();
                translate.language.setLocal('chinese_simplified');
                translate.setAutoDiscriminateLocalLanguage();
                translate.language.setUrlParamControl();
                translate.ignore.class.push('notTranslate');
            }
            catch(e){console.log(e);}
            translate.setUseVersion2();
            translate.nomenclature.append('chinese_simplified','english',`
                568_Calc=568_Calc
            `);
            translate.execute();
        }

        loadingBackground.style.opacity=opacity;
        opacity-=0.4;
    },100);
}