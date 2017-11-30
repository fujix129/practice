const Botkit = require('botkit');

if (!process.env.token) {
  console.log('Error: Specify token in environment');
  process.exit(1);
}

const controller = Botkit.slackbot({
    debug: false
});

controller.spawn({
    token: process.env.token
}).startRTM(function(err){
    if (err) {
        throw new Error(err);
    }
});

var JapaneseHolidays = require('japanese-holidays');

controller.hears('今日は',['direct_message','direct_mention','mention'],function(bot,message) {

  var today = new Date();
  var holiday = JapaneseHolidays.isHoliday(today);
  if(holiday) {
      bot.reply(message,"今日は " + holiday + " でお休みだよ！やったね！");
  } else {
      bot.reply(message,"今日は祝日ではないんだ。働こう。");
  }
});

// say hi
controller.hears('hi',['direct_message','direct_mention','mention'],function(bot,message) {
    bot.reply(message,'hi');
});
