{-# LANGUAGE OverloadedStrings #-}
module EchoHandler where

import qualified Data.HashMap.Strict as H
import           Data.Semigroup
import           Data.Text           (Text)

core :: H.HashMap Text Text -> Maybe Text
core pathParameters =
  case H.lookup "name" pathParameters of
    Just name -> Just ("Hello, " <> name)
    Nothing   -> Nothing

