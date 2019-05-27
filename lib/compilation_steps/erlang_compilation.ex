defmodule CompilationSteps.ErlangCompilation do
  @moduledoc """
  % Example on how to get all Erlang formats from source code to disassembled bytecode

  % Erlang Source --> Erlang AST --> Erlang Expanded AST --> Core Erlang --> BEAM Bytecode

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% First the original module
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  -module(add).
  -export([add/2]).

  add(A, B) ->
          A + B.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% Then the Erlang AST
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  c("add.erl", 'P')

  % Results in

  -file("add.erl", 1).

  -module(add).

  -export([add/2]).

  add(A, B) ->
      A + B.

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% Then the Erlang Expanded AST
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  c("add.erl", 'E').

  % Results in

  -file("add.erl", 1).

  add(A, B) ->
      A + B.

  module_info() ->
      erlang:get_module_info(add).

  module_info(X) ->
      erlang:get_module_info(add, X).

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% Then the Core Erlang format
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  c("add.erl", to_core).

  % Results in

  module 'add' ['add'/2,
                'module_info'/0,
                'module_info'/1]
      attributes []
  'add'/2 =
      %% Line 4
      fun (_cor1,_cor0) ->
          %% Line 5
          call 'erlang':'+'
              (_cor1, _cor0)
  'module_info'/0 =
      fun () ->
          call 'erlang':'get_module_info'
              ('add')
  'module_info'/1 =
      fun (_cor0) ->
          call 'erlang':'get_module_info'
              ('add', _cor0)
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% Finally we can compile to
  %%% BEAM's bytecode, but let's
  %%% see the disassembled format
  %%% instead
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  c("add.erl", 'S').

  % Results in

  {module, add}.  %% version = 0

  {exports, [{add,2},{module_info,0},{module_info,1}]}.

  {attributes, []}.

  {labels, 7}.


  {function, add, 2, 2}.
    {label,1}.
      {line,[{location,"add.erl",4}]}.
      {func_info,{atom,add},{atom,add},2}.
    {label,2}.
      {line,[{location,"add.erl",5}]}.
      {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{x,0}}.
      return.


  {function, module_info, 0, 4}.
    {label,3}.
      {line,[]}.
      {func_info,{atom,add},{atom,module_info},0}.
    {label,4}.
      {move,{atom,add},{x,0}}.
      {line,[]}.
      {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


  {function, module_info, 1, 6}.
    {label,5}.
      {line,[]}.
      {func_info,{atom,add},{atom,module_info},1}.
    {label,6}.
      {move,{x,0},{x,1}}.
      {move,{atom,add},{x,0}}.
      {line,[]}.
      {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.

  """
end
