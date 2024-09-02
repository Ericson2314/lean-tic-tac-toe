import Lake
open Lake DSL

require batteries from git "https://github.com/leanprover-community/batteries.git" @ "v4.10.0"

package «exe» where
  -- add package configuration options here

lean_lib «TicTacToe» where
  -- add library configuration options here

@[default_target]
lean_exe «exe» where
  root := `Main
