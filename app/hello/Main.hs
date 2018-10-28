module Main where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (Text)
import           HelloHandler

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest Text -> IO (APIGatewayProxyResponse Text)
handler request = pure $ responseOK & responseBody?~core

