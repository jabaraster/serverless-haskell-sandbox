{-# LANGUAGE OverloadedStrings #-}
module HttpHandler where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (Text)
import qualified Data.Text                   as DT (pack)
import           Network.HTTP.Simple
import           Network.HTTP.Types
import           System.Directory
import           System.Environment

import           Lib
import           Types

core :: APIGatewayProxyRequest () -> IO HttpInfo
core req = do
  envs    <- getEnvironment
  -- credRes <- httpLbs "http://169.254.169.254/latest/meta-data/iam/security-credentials/"
  files   <- getHomeDirectory >>= getDirectoryContents
  return $ HttpInfo {
             pathParameters = req^.agprqPathParameters
           , headers = map cnv $ req^.agprqHeaders
           , environments = envs
           , securityCredentials = ""
           , files = files
           }
  where
    cnv :: Header -> (Text, Text)
    cnv (name, value) = (DT.pack $ show name, bsToText value)
