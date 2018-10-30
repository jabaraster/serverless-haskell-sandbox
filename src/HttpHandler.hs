module HttpHandler where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (Text)
import qualified Data.Text                   as DT (pack)
import           Network.HTTP.Types
import           System.Environment

import           Lib
import           Types

core :: APIGatewayProxyRequest () -> IO HttpInfo
core req = do
  envs <- getEnvironment
  return $ HttpInfo {
             pathParameters = req^.agprqPathParameters
           , headers = map cnv $ req^.agprqHeaders
           , environments = envs
           }
  where
    cnv :: Header -> (Text, Text)
    cnv (name, value) = (DT.pack $ show name, byteStringToText value)
