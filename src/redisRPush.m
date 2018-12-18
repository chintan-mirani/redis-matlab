function [R, S] = redisRPush(R, list, value)

S = 'OK';

if ~isstr(value)
  S = 'ERROR - SET VALUE MUST BE A STRING';
  return
end

if ~strcmp(R.status, 'open')
  S = 'ERROR - NO CONNECTION';
  return
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('RPUSH %s %s', list, value)));

% the response to an HSET should be :0 or :1
if Response(1) ~= ':'
  S = Response;
  return
end
