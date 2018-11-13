module S3HandlerSpec where

import           Test.Hspec

import           S3Handler

spec :: Spec
spec = do
    it "List buckets test." $ do
        res <- core
        mapM_ print res
