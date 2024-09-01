import Lake
open Lake DSL

require std from git "https://github.com/leanprover-community/batteries.git" @ "v4.7.0"

package «exe» where
  -- add package configuration options here

lean_lib «TicTacToe» where
  -- add library configuration options here

@[default_target]
lean_exe «exe» where
  root := `Main
