const Botkit = require('botkit');

if (!process.env.token) {
  console.log('Error: Specify token in environment');
  process.exit(1);
}

const controller = Botkit.slackbot({
    debug: false
});

//controller.spawn({
//    token: process.env.token
//}).startRTM(function(err){
//    if (err) {
//        throw new Error(err);
//    }
//});

const cron = require('cron');
//const controller = Botkit.slackbot();
controller.spawn({
    token : process.env.token
}).startRTM((err, bot, payload) => {
    new cron.CronJob({
        cronTime: '00 00 18 * * 0-4',
        onTick: () => {
        var now = new Date();
        var tomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1);
        var holiday = JapaneseHolidays.isHoliday(tomorrow);
          if(holiday) {
            bot.say({
              channel: 'bot_test',
              text: "明日は " + holiday + " でお休みだよ！やったね！"
            });
          } else {
             bot.say({
                channel: 'bot_test',
                text:"明日はお仕事。頑張って働こう。"
           });
        }

        },
        start: true,
        timeZone: 'Asia/Tokyo'
    });
});

var JapaneseHolidays = require('japanese-holidays');

controller.hears('明日は',['direct_message','direct_mention','mention'],function(bot,message) {

  var now = new Date();
  var tomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1);
  var holiday = JapaneseHolidays.isHoliday(tomorrow);
  if(holiday) {
      bot.reply(message,"明日は " + holiday + " でお休みだよ！やったね！");
  } else {
      bot.reply(message,"明日は祝日ではないんだ。頑張って働こう。");
  }
});

const GitHubApi = require('github')

var github = new GitHubApi({
  debug:true
})

github.authenticate({
  type: 'token',
  token: process.env.token_github
});

controller.hears('今日やること',['direct_message','direct_mention','mention'],function(bot,message) {
  github.issues.getForOrg({
    org: 'sasekikun',
    filter: 'all'
  }).then(res => {
    var select = Math.floor(Math.random() * res.data.length);
    var title = res.data[select].title;
    var url = res.data[select].html_url;
    if ( title.length ) {
      bot.reply(message,title + "をやろう\n" + url);
    } else {
      bot.reply(message,'どうしよっか。。。');
    }

  });

});


// say hi
controller.hears('hi',['direct_message','direct_mention','mention'],function(bot,message) {
  bot.reply(message,'hi');
});
