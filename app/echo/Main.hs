module Main where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (Text)

import           EchoHandler
-- 以下は()をFromTextのインスタンスにするために必要
import           Types

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest () -> IO (APIGatewayProxyResponse Text)
handler request =
  case core (request^.agprqPathParameters) of
    Just msg -> return $ responseOK & responseBody?~msg
    Nothing  -> return responseNotFound
