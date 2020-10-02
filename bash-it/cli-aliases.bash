function int() {
  if [ -z "$BOSH_ENVIRONMENT" ]; then
    echo "No bosh targeted. Use \"target_bosh\" before trying again"
  else
    TARGETED_BOSH_LITE_NAME=$(echo $BOSH_LITE_DOMAIN | grep lite.cli.fun | cut -d. -f1)
    echo "Loading integration environment variables for $TARGETED_BOSH_LITE_NAME..."

    source ~/workspace/cli-private/set_int_test_lite.sh $TARGETED_BOSH_LITE_NAME
    export SKIP_SSL_VALIDATION=true
  fi
}
