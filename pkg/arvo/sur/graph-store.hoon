|%
+$  uid  @uvH
::
+$  metagraph  (map path graph)
::
+$  graph  (map ship subgraph)
::
+$  subgraph  (map uid post)
::
+$  post
  $:  =uid
      author=ship
      when=time
      =container
      parent=(unit uid)
      children=(list uid)
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
      [%blob mime=@t =beam]
  ==
::
+$  graph-action
  $%  [%create =path]
      [%graph =path =ship =subgraph]
      [%post =path =post]
      [%delete =path]
      [%delete-graph =path =ship]
      [%delete-post =path =ship =uid]
  ==
::
+$  graph-initial
  $%  [%metagraph =metagraph]
      [%graph =path =graph]
      [%subgraph =path =ship =subgraph]
  ==
::
+$  graph-update
  $%  [%keys keys=(set path)]
      [%ships =path keys=(set ship)]
      graph-action
  ==
--
