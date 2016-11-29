module Constants
  PREFIX_KEY ||= 'tmb'
  EVENT_TYPE_MESSAGE ||= 'message'
  COMMANDS ||= {PING: 'ping', SET_CLEANING_DATE: 'set-cleaning-date', GET_CLEANING_DATE: 'get-cleaning-date', SET_DAIJIN: 'set-daijin',GET_DAIJIN: 'get-daijin', GET_ACCOUNT: 'get-account',HAT: 'hat' , HELP: 'help'}
  MEMBER_LIST ||= (ENV['MEMBER_LIST']||'Tom,John').split
  ELIGIBLE_SOURCE ||= (ENV['ELIGIBLE_SOURCE']||'111,222').split
  ACCOUNT ||= ENV['ACCOUNT']
end