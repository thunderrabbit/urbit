/-  *chat-store, *chat-view
/+  chat-eval
|%
::
++  slan  |=(mod/@tas |=(txt/@ta (need (slaw mod txt))))
::
++  seri                                              :::  serial
  =,  dejs:format
  ^-  $-(json serial)
  (cu (slan %uv) so)
::
++  re                                                ::  recursive reparsers
  |*  {gar/* sef/_|.(fist:dejs-soft:format)}
  |=  jon/json
  ^-  (unit _gar)
  =-  ~!  gar  ~!  (need -)  -
  ((sef) jon)
::
++  dank                                              ::  tank
  ^-  $-(json (unit tank))
  =,  ^?  dejs-soft:format
  %+  re  *tank  |.  ~+
  %-  of  :~
    leaf+sa
    palm+(ot style+(ot mid+sa cap+sa open+sa close+sa ~) lines+(ar dank) ~)
    rose+(ot style+(ot mid+sa open+sa close+sa ~) lines+(ar dank) ~)
  ==
::
++  eval                                              :::  %exp speech
  :::  extract contents of an %exp speech, evaluating
  :::  the {exp} if there is no {res} yet.
  ::
  |=  a=json
  ^-  [cord (list tank)]
  =,  ^?  dejs-soft:format
  =+  exp=((ot expression+so ~) a)
  %-  need
  ?~  exp  [~ '' ~]
  :+  ~  u.exp
  ::  NOTE  when sending, if output is an empty list, chat-store will evaluate
  (fall ((ot output+(ar dank) ~) a) ~)
::
++  conte
  |=  =content
  ^-  json
  =,  enjs:format
  ?-  -.content
      %text  (frond %text s+text.content)
      %url   (frond %url s+url.content)
      %me    (frond %me s+narrative.content)
  ::
      %code
    %+  frond  %code
    %-  pairs
    :~  [%expression s+expression.content]
        [%output a+(turn output.content tank)]
    ==
  ==
::
++  mesg
  |=  =message
  ^-  json
  =,  enjs:format
  %-  pairs
  :~  [%uid s+(scot %uv uid.message)]
      [%number (numb number.message)]
      [%author (ship author.message)]
      [%when (time when.message)]
      [%content (conte content.message)]
  ==
::
++  conf
  |=  =config
  ^-  json
  =,  enjs:format
  %-  pairs
  :~  [%length (numb length.config)]
      [%read (numb read.config)]
  ==
::
++  inbox-to-configs
  |=  =inbox
  ^-  chat-configs
  %-  ~(run by inbox)
  |=  =chatroom
  ^-  config
  config.chatroom
::
++  configs-to-json
  |=  cfg=chat-configs
  =,  enjs:format
  ^-  json
  %+  frond  %chat-configs
  %-  pairs
  %+  turn  ~(tap by cfg)
  |=  [pax=^path =config]
  ^-  [cord json]
  [(spat pax) (conf config)]
::
++  inbox-to-json
  |=  box=inbox
  =,  enjs:format
  ^-  json
  %+  frond  %chat-initial
  %-  pairs
  %+  turn  ~(tap by box)
  |=  [pax=^path =chatroom]
  ^-  [cord json]
  :-  (spat pax)
  %-  pairs
  :~  [%messages [%a (turn messages.chatroom mesg)]]
      [%config (conf config.chatroom)]
  ==
::
++  update-to-json
  |=  upd=chat-update
  =,  enjs:format
  ^-  json
  %+  frond  %chat-update
  %-  pairs
  :~
    ?:  =(%message -.upd)
      ?>  ?=(%message -.upd)
      :-  %message
      %-  pairs
      :~  [%path (path path.upd)]
          [%message (mesg message.upd)]
      ==
    ?:  =(%read -.upd)
      ?>  ?=(%read -.upd)
      [%read (pairs [%path (path path.upd)]~)]
    ?:  =(%create -.upd)
      ?>  ?=(%create -.upd)
      :-  %create
      %-  pairs
      :~  [%ship (ship ship.upd)]
          [%path (path path.upd)]
      ==
    ?:  =(%delete -.upd)
      ?>  ?=(%delete -.upd)
      [%delete (pairs [%path (path path.upd)]~)]
    ?:  =(%config -.upd)
      ?>  ?=(%config -.upd)
      :-  %config
      %-  pairs
      :~  [%path (path path.upd)]
          [%config (conf config.upd)]
      ==
    [*@t *^json]
  ==
::
++  json-to-action
  |=  jon=json
  ^-  chat-action
  =,  dejs:format
  =<  (parse-json jon)
  |%
  ++  parse-json
    %-  of
    :~  [%create create]
        [%delete delete]
        [%message message]
        [%read read]
    ==
  ::
  ++  create
    %-  ot
    :~  [%ship (su ;~(pfix sig fed:ag))]
        [%path pa]
    ==
  ::
  ++  delete
    (ot [%path pa]~)
  ::
  ++  message
    %-  ot
    :~  [%path pa]
        [%message msg]
    ==
  ::
  ++  read
    (ot [%path pa] ~)
  ::
  ++  msg
    %-  ot
    :~  [%uid seri]
        [%number ni]
        [%author (su ;~(pfix sig fed:ag))]
        [%when di]
        [%content content]
    ==
  ::
  ++  content
    %-  of
    :~  [%text so]
        [%url so]
        [%code eval]
        [%me so]
    ==
  ::
  --
::
++  json-to-view-action
  |=  jon=json
  ^-  chat-view-action
  =,  dejs:format
  =<  (parse-json jon)
  |%
  ++  parse-json
    %-  of
    :~  [%create create]
        [%delete delete]
        [%join join]
    ==
  ::
  ++  create
    %-  ot
    :~  [%path pa]
        [%security sec]
        [%read (as (su ;~(pfix sig fed:ag)))]
        [%write (as (su ;~(pfix sig fed:ag)))]
    ==
  ::
  ++  delete
    (ot [%path pa]~)
  ::
  ++  join
    %-  ot
    :~  [%ship (su ;~(pfix sig fed:ag))]
        [%path pa]
    ==
  ::
  ++  sec
    =,  dejs:format
    ^-  $-(json chat-security)
    (su (perk %channel %village %journal %mailbox ~))
  --
--

