const { WebClient } = require('@slack/web-api');
require('dotenv').config();

(async () => {
  const token  = process.env.SLACK_TOKEN;
  const channel = '#test';
  const text = '*Hello Hello World*';
  const client = new WebClient(token);
  console.log(token);
  const response = await client.chat.postMessage({ channel, text });
  console.log(response.ok);
})();