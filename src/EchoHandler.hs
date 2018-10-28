{-# LANGUAGE OverloadedStrings #-}
module EchoHandler where

import           AWSLambda.Events.APIGateway
import           Control.Lens
import qualified Data.HashMap.Strict         as HashMap
import           Data.Semigroup
import           Data.Text                   (Text)

handler :: APIGatewayProxyRequest Text -> IO (APIGatewayProxyResponse Text)
handler request = do
  putStrLn "This should go to logs"
  case HashMap.lookup "name" (request ^. agprqPathParameters) of
    Just name -> return $ responseOK & responseBody ?~ "Hello, " <> name
    Nothing -> return responseNotFound
