module GetDataHandlerSpec where

import           Test.Hspec

import           GetDataHandler

spec :: Spec
spec = do
    it "DynamoDB Scan test." $ do
        res <- core
        mapM_ print res
