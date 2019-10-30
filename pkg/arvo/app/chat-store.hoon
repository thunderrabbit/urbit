:: chat-store: data store that holds linear sequences of chat messages
::
/+  *chat-json, *chat-eval
|%
+$  move  [bone card]
::
+$  card
  $%  [%diff diff]
      [%quit ~]
  ==
::
+$  state
  $%  [%0 state-zero]
  ==
::
+$  state-zero
  $:  =inbox
  ==
::
+$  diff
  $%  [%chat-initial inbox]
      [%chat-configs chat-configs]
      [%chat-update chat-update]
  ==
--
::
|_  [bol=bowl:gall state]
::
++  this  .
::
++  prep
  |=  old=(unit state)
  ^-  (quip move _this)
  [~ ?~(old this this(+<+ u.old))]
::
++  peek-x-all
  |=  pax=path
  ^-  (unit (unit [%noun (map path chatroom)]))
  [~ ~ %noun inbox]
::
++  peek-x-configs
  |=  pax=path
  ^-  (unit (unit [%noun chat-configs]))
  :^  ~  ~  %noun
  (inbox-to-configs inbox)
::
++  peek-x-keys
  |=  pax=path
  ^-  (unit (unit [%noun (set path)]))
  [~ ~ %noun ~(key by inbox)]
::
++  peek-x-chatroom
  |=  pax=path
  ^-  (unit (unit [%noun (unit chatroom)]))
  ?~  pax  ~
  =/  chatroom=(unit chatroom)  (~(get by inbox) pax)
  [~ ~ %noun chatroom]
::
++  peek-x-config
  |=  pax=path
  ^-  (unit (unit [%noun config]))
  ?~  pax  ~
  =/  chatroom  (~(get by inbox) pax)
  ?~  chatroom  ~
  :^  ~  ~  %noun
  config.u.chatroom
::
++  peek-x-messages
  |=  pax=path
  ^-  (unit (unit [%noun (list message)]))
  ?+  pax  ~
      [@ @ *]
    =/  mail-path  t.t.pax
    =/  chatroom  (~(get by inbox) mail-path)
    ?~  chatroom
      [~ ~ %noun ~]
    =*  messages  messages.u.chatroom
    =/  sign-test=[?(%neg %pos) @]
      %-  need
      %+  rush  i.pax
      ;~  pose
        %+  cook
          |=  n=@
          [%neg n]
        ;~(pfix hep dem:ag)
      ::
        %+  cook
          |=  n=@
          [%pos n]
        dem:ag
      ==
    =*  length  length.config.u.chatroom
    =*  start  +.sign-test
    ?:  =(-.sign-test %neg)
      ?:  (gth start length)
        [~ ~ %noun messages]
      [~ ~ %noun (swag [(sub length start) start] messages)]
    ::
    =/  end  (slav %ud i.t.pax)
    ?.  (lte start end)
      ~
    =.  end  ?:((lth end length) end length)
    [~ ~ %noun (swag [start (sub end start)] messages)]
  ==
::
++  peer-keys
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ::  we send the list of keys then send events when they change
  :_  this
  [ost.bol %diff %chat-update [%keys ~(key by inbox)]]~
::
++  peer-all
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  :_  this
  [ost.bol %diff %chat-initial inbox]~
::
++  peer-configs
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  :_  this
  [ost.bol %diff %chat-configs (inbox-to-configs inbox)]~
::
++  peer-updates
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ::  we now proxy all events to this path
  [~ this]
::
++  peer-chatroom
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ?>  (~(has by inbox) pax)
  =^  =ship  pax
    ?>  ?=([* ^] pax)
    [(slav %p i.pax) t.pax]
    :_  this
  [ost.bol %diff %chat-update [%create ship pax]]~
::
++  poke-json
  |=  jon=json
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  (poke-chat-action (json-to-action jon))
::
++  poke-chat-action
  |=  action=chat-action
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ?-  -.action
      %create   (handle-create action)
      %delete   (handle-delete action)
      %message  (handle-message action)
      %read     (handle-read action)
  ==
::
++  handle-create
  |=  act=chat-action
  ^-  (quip move _this)
  ?>  ?=(%create -.act)
  =/  pax  [(scot %p ship.act) path.act]
  ?:  (~(has by inbox) pax)
    [~ this]
  :-  (send-diff pax act)
  this(inbox (~(put by inbox) pax *chatroom))
::
++  handle-delete
  |=  act=chat-action
  ^-  (quip move _this)
  ?>  ?=(%delete -.act)
  =/  chatroom=(unit chatroom)  (~(get by inbox) path.act)
  ?~  chatroom
    [~ this]
  :-  (send-diff path.act act)
  this(inbox (~(del by inbox) path.act))
::
++  handle-message
  |=  act=chat-action
  ^-  (quip move _this)
  ?>  ?=(%message -.act)
  =/  chatroom=(unit chatroom)  (~(get by inbox) path.act)
  ?~  chatroom
    [~ this]
  =*  content  content.message.act
  =?  content  &(?=(%code -.content) ?=(~ output.content))
    =/  =hoon  (ream expression.content)
    content(output (eval bol hoon))
  =:  length.config.u.chatroom  +(length.config.u.chatroom)
      number.message.act  +(length.config.u.chatroom)
      messages.u.chatroom  (snoc messages.u.chatroom message.act)
  ==
  :-  (send-diff path.act act)
  this(inbox (~(put by inbox) path.act u.chatroom))
::
++  handle-read
  |=  act=chat-action
  ^-  (quip move _this)
  ?>  ?=(%read -.act)
  =/  chatroom=(unit chatroom)  (~(get by inbox) path.act)
  ?~  chatroom
    [~ this]
  =.  read.config.u.chatroom  length.config.u.chatroom
  :-  (send-diff path.act act)
  this(inbox (~(put by inbox) path.act u.chatroom))
::
++  update-subscribers
  |=  [pax=path act=chat-action]
  ^-  (list move)
  %+  turn  (prey:pubsub:userlib pax bol)
  |=  [=bone *]
  [bone %diff %chat-update act]
::
++  send-diff
  |=  [pax=path act=chat-action]
  ^-  (list move)
  %-  zing
  :~  (update-subscribers /all act)
      (update-subscribers /updates act)
      (update-subscribers [%chatroom pax] act)
      ?.  |(=(%read -.act) =(%message -.act))
        ~
      (update-subscribers /configs act)
      ?.  |(=(%create -.act) =(%delete -.act))
        ~
      (update-subscribers /keys act)
  ==
::
--
