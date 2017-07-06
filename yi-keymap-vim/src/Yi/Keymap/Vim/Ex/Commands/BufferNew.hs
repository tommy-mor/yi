{-# LANGUAGE OverloadedStrings #-}
-- |
-- Module      : Yi.Keymap.Vim.Ex.Commands.BufferNew
-- License     : GPL-2
-- Maintainer  : yi-devel@googlegroups.com
-- Stability   : experimental
-- Portability : portable

module Yi.Keymap.Vim.Ex.Commands.BufferNew (parse) where

import           Control.Applicative              (Alternative(..))
import           Control.Monad                    (void)
import qualified Data.Attoparsec.Text as P        (string,try)
import           Data.Text                        (Text)
import           Yi.Buffer                        (BufferId (MemBuffer))
import           Yi.Editor                        (newEmptyBufferE,switchToBufferE)
import           Yi.Keymap                        (Action (EditorA))
import           Yi.Keymap.Vim.Common             (EventString)
import qualified Yi.Keymap.Vim.Ex.Commands.Common as Common (parse,pureExCommand)
import           Yi.Keymap.Vim.Ex.Types           (ExCommand (cmdAction, cmdShow))

parse :: EventString -> Maybe ExCommand
parse = Common.parse $ do
    void $ P.string "new"
    return $ Common.pureExCommand {
        cmdShow = "new"
      , cmdAction = EditorA $ newEmptyBufferE (MemBuffer "New Buffer") >>=
          switchToBufferE
      }
