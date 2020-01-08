trigger AccountTrigger on Account (after delete) {
for(Account acc: Trigger.old);
}