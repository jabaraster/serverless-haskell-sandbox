module Main where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Text                   (Text)
import           EchoHandler

main :: IO ()
main = apiGatewayMain handler

handler :: APIGatewayProxyRequest Text -> IO (APIGatewayProxyResponse Text)
handler request =
  case core (request^.agprqPathParameters) of
    Just msg -> return $ responseOK & responseBody?~msg
    Nothing -> return responseNotFound
