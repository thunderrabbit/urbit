|%
+$  serial  @uvH
::
+$  content
  $%  [%text text=cord]
      [%url url=cord]
      [%code expression=cord output=(list tank)]
      [%me narrative=cord]
  ==
::
+$  message
  $:  uid=serial
      number=@
      author=ship
      when=time
      =content
  ==
::
+$  config
  $:  length=@
      read=@
  ==
::
+$  chatroom
  $:  =config
      messages=(list message)
  ==
::
+$  inbox  (map path chatroom)
::
+$  chat-configs  (map path config)
::
+$  chat-action
  $%  [%create =ship =path]         ::  %create: create chatroom at ~ship/path
      [%delete =path]               ::  %delete: delete chatroom at path
      [%message =path =message]     ::  %message: append message to chatroom
      [%read =path]                 ::  %read: set chatroom to read
  ==
::
+$  chat-update
  $%  [%keys keys=(set path)]
      [%config =path =config]
      chat-action
  ==
--
