|%
+$  serial  @uvH
::
+$  meta-timeline  (map path timeline)
::
+$  timeline
  $:  time-feed=feed
      ship-feeds=(map ship feed)
  ==
::
+$  feed  (list post)
::
+$  post
  $:  =uid
      author=ship
      when=time
      =container
      parent=(unit serial)
      children=(list serial)
  ==
::
+$  container
  $%  [%content =content] 
      [%multiple multiple=(list content)]
  ==
::
+$  content
  $%  [%text text=cord]
      [%url url=cord]
      [%udon udon=manx]
      ::  [%blob mime=@t =ship app=@tas =path]
  ==
::
+$  feed-action
  $%  ::  %path: initialize a path to an empty map of uid to thread
      ::
      [%create-feed =path]
      ::  %post: if post is last package in list, append to list
      ::  if post is not last package in list, create reply-thread
      ::
      [%post =path =ship =post]
      ::  %delete-timeline: delete a timeline at path
      ::
      [%delete-timeline =path]
      ::  %delete-ship-feed: delete a graph at path
      ::
      [%delete-ship-feed =path =ship]
      ::  %delete-path: delete a specific ship's post-graph at path
      ::
      [%oust-time-feed =path start=@ end=@]
  ==
::
+$  graph-initial
  $%  [%meta-graph =meta-graph]
      [%ship-graph =path =ship-graph]
      [%post-graph =path =ship =post-graph]
  ==
::
+$  graph-update
  $%  [%keys keys=(set path)]
      [%ships =path keys=(set ship)]
      graph-action
  ==
--
