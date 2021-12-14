var Slack = require('slack-node');
var request = require('request');
var fs = require('fs');

apiToken = "xoxp-308073870612-307990994083-654907275393-e16777ff27a712b125503439716821ae"; // ここにAPIトークンを貼り付ける。
slack = new Slack(apiToken);

slack.api("emoji.list", function (err, response) {
    for(key in response.emoji){
        url = response.emoji[key];
        //エイリアスは無視
        if(url.match(/alias/)){
            continue;
        }

        // 取得対象の拡張子
        extention = url.match(/\.[^\.]+$/);

        request
        .get(url)
        .on('response', function (res) {
        })
        .on('error', function(err) {
        })
        .pipe(fs.createWriteStream('image/' + key + extention));
    }
});
