module Yi.Keymap.Vim2.Ex.Eval
    ( exEvalE
    , exEvalY
    ) where

import Prelude ()
import Yi.Prelude

import Yi.Editor
import Yi.Keymap
import Yi.Keymap.Vim2.Ex.Types

exEvalE :: [ExCommandBox] -> String -> EditorM ()
exEvalE cmds cmdString = evalHelper id (const $ error msg) cmds cmdString
    where msg = "exEvalE got impure command" ++ cmdString

exEvalY :: [ExCommandBox] -> String -> YiM ()
exEvalY = evalHelper withEditor id

evalHelper :: MonadEditor m =>
    (EditorM () -> m ()) -> (YiM () -> m ()) ->
    [ExCommandBox] -> String -> m ()
evalHelper pureHandler impureHandler cmds cmdString =
    case stringToExCommand cmds cmdString of
        Just cmd -> case cmdAction cmd of
                      Left pureAction -> pureHandler pureAction
                      Right impureAction -> impureHandler impureAction
        _ -> return ()
