function [V, R, S] = redisLPop(R, list)

S = 'OK';
V = [];

if ~strcmp(R.status, 'open')
  S = 'ERROR - NO CONNECTION';
  return
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('LPOP %s', list)));

if Response(1) ~= '$'
  S = Response;
  return
end

% response $-1 means nonexistant key
if Response(2) == '-'
  S = 'ERROR - NONEXISTANT KEY'
  return
end

parts = regexp(Response, '\r\n', 'split');
V = parts{2};
