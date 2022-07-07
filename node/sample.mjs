const slack_app_token = 'xxx'
const channel_id = '#test'
const text = 'テスト'

let headers = {
    "Content-Type": "application/json",
    "Authorization": `Bearer ${slack_app_token}`
}
let body = {
    channel: channel_id,
    text: text
}
var post_uri = "https://slack.com/api/chat.postMessage";
const res = await fetch(post_uri, {method: 'POST', body: JSON.stringify(body), headers: headers});
if (res.ok) {
    const data = await res.json();
    console.log(data);
}