#!/bin/bash

FOLDER_NAME=$1;
DOCKER_MODE=$2;

usage() {
  echo "Usage: $0 <folder name>"
  exit 1
}

initialize_git() {

git init "$FOLDER_NAME"

cd "$FOLDER_NAME"

}

generate_gitignore() {

cat <<EOT >> .gitignore
# See https://help.github.com/articles/ignoring-files/ for more about ignoring files.

# dependencies
/node_modules
/.pnp
.pnp.js

# testing
/coverage

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# local env files
.env.local
.env.development.local
.env.test.local
.env.production.local

EOT

}

generate_config_files() {

cat <<EOT >> package.json
{ 
  "name": "$FOLDER_NAME",
  "version": "1.0.0",
  "description": "",
  "main": "build/index.js",
  "scripts": {
  	"dev": "ts-node-dev ./src/index.ts",
  	"build": "tsc",
  	"start": "tsc & node ."
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {},
  "devDependencies": {}
}
EOT

cat <<EOT >> tsconfig.json
{
  "compilerOptions": {
    /* Visit https://aka.ms/tsconfig.json to read more about this file */
    /* Basic Options */
    // "incremental": true,                   /* Enable incremental compilation */
    "target": "es5",                          /* Specify ECMAScript target version: 'ES3' (default), 'ES5', 'ES2015', 'ES2016', 'ES2017', 'ES2018', 'ES2019', 'ES2020', or 'ESNEXT'. */
    "module": "commonjs",                     /* Specify module code generation: 'none', 'commonjs', 'amd', 'system', 'umd', 'es2015', 'es2020', or 'ESNext'. */
    "strict": true,                           /* Enable all strict type-checking options. */
    "allowJs": true,                          /* Allow javascript files to be compiled. */
    "esModuleInterop": true,                  /* Enables emit interoperability between CommonJS and ES Modules via creation of namespace objects for all imports. Implies 'allowSyntheticDefaultImports'. */
    "skipLibCheck": true,                     /* Skip type checking of declaration files. */
    "baseUrl": "./",                          /* Base directory to resolve non-absolute module names. */
    "outDir": "./build",                      /* Redirect output structure to the directory. */
    "paths": {
      "*": [
        "node_modules/*"
      ]
    },                                        /* A series of entries which re-map imports to lookup locations relative to the 'baseUrl'. */
    "forceConsistentCasingInFileNames": true, /* Disallow inconsistently-cased references to the same file. */
    // "lib": [],                             /* Specify library files to be included in the compilation. */
    // "checkJs": true,                       /* Report errors in .js files. */
    // "jsx": "preserve",                     /* Specify JSX code generation: 'preserve', 'react-native', or 'react'. */
    // "declaration": true,                   /* Generates corresponding '.d.ts' file. */
    // "declarationMap": true,                /* Generates a sourcemap for each corresponding '.d.ts' file. */
    // "sourceMap": true,                     /* Generates corresponding '.map' file. */
    // "outFile": "./",                       /* Concatenate and emit output to single file. */
    // "rootDir": "./",                       /* Specify the root directory of input files. Use to control the output directory structure with --outDir. */
    // "composite": true,                     /* Enable project compilation */
    // "tsBuildInfoFile": "./",               /* Specify file to store incremental compilation information */
    // "removeComments": true,                /* Do not emit comments to output. */
    // "noEmit": true,                        /* Do not emit outputs. */
    // "importHelpers": true,                 /* Import emit helpers from 'tslib'. */
    // "downlevelIteration": true,            /* Provide full support for iterables in 'for-of', spread, and destructuring when targeting 'ES5' or 'ES3'. */
    // "isolatedModules": true,               /* Transpile each file as a separate module (similar to 'ts.transpileModule'). */
    /* Strict Type-Checking Options */
    // "noImplicitAny": true,                 /* Raise error on expressions and declarations with an implied 'any' type. */
    // "strictNullChecks": true,              /* Enable strict null checks. */
    // "strictFunctionTypes": true,           /* Enable strict checking of function types. */
    // "strictBindCallApply": true,           /* Enable strict 'bind', 'call', and 'apply' methods on functions. */
    // "strictPropertyInitialization": true,  /* Enable strict checking of property initialization in classes. */
    // "noImplicitThis": true,                /* Raise error on 'this' expressions with an implied 'any' type. */
    // "alwaysStrict": true,                  /* Parse in strict mode and emit "use strict" for each source file. */
    /* Additional Checks */
    // "noUnusedLocals": true,                /* Report errors on unused locals. */
    // "noUnusedParameters": true,            /* Report errors on unused parameters. */
    // "noImplicitReturns": true,             /* Report error when not all code paths in function return a value. */
    // "noFallthroughCasesInSwitch": true,    /* Report errors for fallthrough cases in switch statement. */
    // "noUncheckedIndexedAccess": true,      /* Include 'undefined' in index signature results */
    /* Module Resolution Options */
    // "moduleResolution": "node",            /* Specify module resolution strategy: 'node' (Node.js) or 'classic' (TypeScript pre-1.6). */
    // "rootDirs": [],                        /* List of root folders whose combined content represents the structure of the project at runtime. */
    // "typeRoots": [],                       /* List of folders to include type definitions from. */
    // "types": [],                           /* Type declaration files to be included in compilation. */
    // "allowSyntheticDefaultImports": true,  /* Allow default imports from modules with no default export. This does not affect code emit, just typechecking. */
    // "preserveSymlinks": true,              /* Do not resolve the real path of symlinks. */
    // "allowUmdGlobalAccess": true,          /* Allow accessing UMD globals from modules. */
    /* Source Map Options */
    // "sourceRoot": "",                      /* Specify the location where debugger should locate TypeScript files instead of source locations. */
    // "mapRoot": "",                         /* Specify the location where debugger should locate map files instead of generated locations. */
    // "inlineSourceMap": true,               /* Emit a single file with source maps instead of having a separate file. */
    // "inlineSources": true,                 /* Emit the source alongside the sourcemaps within a single file; requires '--inlineSourceMap' or '--sourceMap' to be set. */
    /* Experimental Options */
    // "experimentalDecorators": true,        /* Enables experimental support for ES7 decorators. */
    // "emitDecoratorMetadata": true,         /* Enables experimental support for emitting type metadata for decorators. */
    /* Advanced Options */
  },
  "include": [
    "src/**/*.ts",
  ],
  "exclude": [
    "node_modules"
  ]
}
EOT

}

generate_directories() {

mkdir -p src src/config src/routes src/server src/lib/middleware src/lib/errors 

}

generate_boilerplate() {

echo "Creating Boilerplate..."

generate_directories

cat <<EOT >> ./src/index.ts
import { config } from './config';
import { app } from './server/express';

// Constants
const PORT = config.port;
const HOST = config.host;


app.listen(PORT, HOST, () => {
    console.log(\`Running on http://\${HOST}:\${PORT}\`);
});
EOT

cat <<EOT >> ./src/config/index.ts
const config = {
    host : "0.0.0.0",
    port : 3000,
}

export { config }
EOT

cat <<EOT >> ./src/routes/index.ts
import express from 'express';
const router = express.Router();

router.use("/", (req, res) => {
    res.status(200).json({
        status: "OK?"
    })
})

export { router as rootRouter };
EOT

cat <<EOT >> ./src/server/express.ts 
import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import morgan from 'morgan';
import { rootRouter } from '../routes';

require('express-async-errors');

// Initialize express app
const app = express()


// Middlewares
const cors_middleware = cors();
const helmet_middleware = helmet();
const logger_middleware = morgan('combined')

app.use(cors_middleware);
app.use(helmet_middleware);
app.use(logger_middleware);

// Router
app.use(rootRouter)

// Default Route handling
app.use('*', async (req, res) => {
  res.status(404).json({ error: 'Not found' });
});


export { app };
EOT

}


install_deps_locally() {
echo "Installing dependancies..."

yarn add cors express express-async-errors helmet morgan > /dev/null 2>&1
yarn add --dev  @types/cors @types/express @types/morgan @types/node jest ts-node-dev typescript > /dev/null 2>&1

}

if [ -z $FOLDER_NAME ]
then
  echo "Error: missing parameters."
  usage
fi

initialize_git

generate_gitignore

generate_config_files

generate_boilerplate

install_deps_locally

echo "Successfully Generated Expressjs Boilerplate, cd $FOLDER_NAME then, yarn dev to continue"
