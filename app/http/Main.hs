module Main where

import           Control.Lens
import           Data.Aeson
import qualified Data.ByteString.Lazy.Char8  as DB (unpack)
import           Data.Text                   (Text)
import qualified Data.Text                   as DT (pack)

import           AWSLambda.Events.APIGateway

import           HttpHandler
import           Types

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest () -> IO (APIGatewayProxyResponse HttpInfo)
handler request = do
  res <- core request
  return $ responseOK&responseBody ?~ res

