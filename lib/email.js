// fs = require('fs');
//
// var mailgun = require('mailgun.js');
// var logSystem = 'email';
//
// // Sends out an email using the mailgun API.
// exports.notifyAddress = function(address, subject, template) {
//
//     // Return early when emailing is not enabled.
//     if (!config.email.enabled) {
//       return;
//     }
//     var api_key = config.email.api_key;
//     var api_domain = config.email.api_domain;
//     var mg = mailgun.client({username: 'api', key: api_key});
//     var email;
//     var body = getEmailTemplate(template);
//
//     // Fetch the email address.
//     redisClient.hget(config.coin + ':notifications:', address, function(error, value){
//         if (error || value == undefined){
//             // We don't really consider this an error because we liberally call
//             // this mail function on all addresses. Most will not have
//             // registered an email address.
//             return false;
//         }
//
//         mg.messages.create(api_domain, {
//           from: config.email.from_address,
//           to: value,
//           subject: subject,
//           text: body
//         });
//     });
// };
//
// // Reads an email template file and returns it.
// function getEmailTemplate(template_name) {
//   var replacement = [
//     [/%POOL_HOST%/g, config.email.domain],
//   ];
//
//   // Read the file and replace the macros in the template.
//   var content = fs.readFileSync(config.email.template_dir + '/' + template_name, 'utf8');
//   for (var i = 0; i < replacement.length; i++) {
//       content = content.replace(replacement[i][0], replacement[i][1]);
//   }
//   return content;
// };
//
