/**
 * ==VimperatorPlugin==
 * @name           migemo_completion.js
 * @description    replace completion function with using Migemo
 * @description-ja 補完関数をMigemoを使用したものに取り替える
 * @author         Trapezoid
 * @version        0.2
 * ==/VimperatorPlugin==
 *
 * Support commands:
 *  - :buffer
 *  - :sidebar
 *  - :emenu
 *  - :dialog
 *  - :help
 *  - :macros
 *  - :play
 *  and more
 **/

(function(){
  var XMigemoCore = Components.classes["@piro.sakura.ne.jp/xmigemo/factory;1"]
                              .getService(Components.interfaces.pIXMigemoFactory)
                              .getService("ja");
  var XMigemoTextUtils = Components.classes["@piro.sakura.ne.jp/xmigemo/text-utility;1"]
                                   .getService(Components.interfaces.pIXMigemoTextUtils);

  function replaceFunction(target,symbol,f,originalArguments){
      var oldFunction = target[symbol];
      target[symbol] = function() f.apply(target,[oldFunction.apply(target,originalArguments || arguments),arguments]);
  }

  replaceFunction(liberator.modules.completion,"buffer",function(oldResult,args){
      var filter = args[0];
      var migemoPattern = new RegExp(XMigemoCore.getRegExp(filter));
      return [0,oldResult[1].filter(function([value,label]) migemoPattern.test(value) || migemoPattern.test(label))];
  },[""]);

  liberator.modules.completion.filter = function(array,filter,matchFromBeginning,favicon){
      if (!filter)
          return [[a[0], a[1], favicon ? a[2] : null] for each (a in array)];

      let original = XMigemoTextUtils.sanitize(filter);
      let migemoString = XMigemoCore.getRegExp(filter);
      migemoString = original + "|" + migemoString;
      if(matchFromBeginning)
          migemoString ="^(" + migemoString + ")";
      var migemoPattern = new RegExp(migemoString,"i");

      let result = [];
      for (let [,item] in Iterator(array)){
          let complist = item[0] instanceof Array ? item[0] : [item[0]];
          for (let [,compitem] in Iterator(complist)){
              if (migemoPattern.test(compitem) || migemoPattern.test(item[1])){
                result.push([compitem,item[1],favicon ? item[2] : null]);
                break;
              }
          }
      }
      return result;
  };
})();
