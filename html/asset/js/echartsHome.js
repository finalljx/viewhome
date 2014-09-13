var version = '2.0.2';
var curPage = location.href.match(/(\w*).html/) ? location.href.match(/(\w*).html/)[1] : 'index';

var activeClass = {};
var loc = {};
var forkWidth = 149;
switch (curPage) {
    case 'index' :
        activeClass[curPage] = 'active';
        loc[curPage] = '.';
        loc.feature = './doc';
        loc.example = './doc';
        loc.doc = './doc';
        loc.about = './doc';
        loc.changelog = './doc';
        loc.start = './doc';
        loc.img = './doc';
        break;
    case 'feature' :
    case 'example' :
    case 'doc' :
    case 'about' :
    case 'changelog' :
    case 'start' :
        activeClass[curPage] = 'active';
        loc.index = '..';
        break;
    default :
        forkWidth = 60;
        activeClass['example'] = 'active';
        loc.index = '../..';
        loc.feature = '../../doc';
        loc.example = '../../doc';
        loc.doc = '../../doc';
        loc.about = '../../doc';
        loc.changelog = '../../doc';
        loc.start = '../../doc';
        loc.img = '../../doc';
        break;
}

function back2Top() {
    $("body,html").animate({scrollTop:0},1000);
    return false;
}
$('#footer')[0].style.marginTop = '50px';

if (document.location.href.indexOf('local') == -1) {
    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fb78830c9a5dad062d08b90b2bc0cf5da' type='text/javascript'%3E%3C/script%3E"));   
}

function fixFork () {
    var navMarginRight = 0;
    var bodyWidth = document.body.offsetWidth;
    if (bodyWidth < 1440) {
        navMarginRight = 150 - (bodyWidth - contnetWidth) / 2;
    }
    $('#nav')[0].style.marginRight = navMarginRight + 'px';
    $('#fork-image')[0].style.width = (document.body.offsetWidth < 768 ? 1 : forkWidth) + 'px';
};
//fixFork();
$(window).on('resize', fixFork);