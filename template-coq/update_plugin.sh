#!/usr/bin/env bash
SED=`which gsed || which sed`
TOCOPY="ast_denoter.ml ast_quoter.ml denoter.ml plugin_core.ml plugin_core.mli reification.ml quoter.ml run_extractable.ml run_extractable.mli tm_util.ml"

# Test is gen-src is older than src
if [[ "gen-src" -ot "src" || ! -f "gen-src/denoter.ml" || ! -f "gen-src/metacoq_template_plugin.cmxs" ||
  "gen-src/extractable.ml" -nt "gen-src/metacoq_template_plugin.cmxs" ]]
then
    echo "Updating gen-src from src"
    mkdir -p build
    echo "Copying from src to gen-src"
    for x in ${TOCOPY}; do rm -f gen-src/$x; cp src/$x gen-src/$x; done
    echo "Renaming files to camelCase"
    (cd gen-src; ./to-lower.sh)
    rm -f gen-src/*.d
    # Fix an extraction bug: wrong type annotation on eq_equivalence
    ${SED} -i.bak 's/\r//g' gen-src/cRelationClasses.mli
    patch -N -p0 < extraction.patch
    exit 0
else
    echo "Extracted code is up-to-date"
fi
