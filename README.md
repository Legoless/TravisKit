TravisKit
=========

Full unofficial native block based [Travis CI](http://travis-ci.org) API Wrapper for iOS / OS X based on [AFNetworking](https://github.com/AFNetworking/AFNetworking) 2.x and [JSONModel](https://github.com/icanzilb/JSONModel) mapping.

# Installation
The easiest way to setup TravisKit is with CocoaPods.

```ruby
pod TravisKit, '~> 1.0'
```

Alternatively, you can drag & drop the `TravisKit` folder into your project. Note that you need to install `AFNetworking` and `JSONModel` as well, as `TravisKit` will not work without them.


# Authentication

Travis CI uses authentication tokens from GitHub, which can be obtained with:

- [OctoKit](https://github.com/octokit/octokit.objc)
- [AuthKit](https://github.com/Legoless/AuthKit)
- ...

Or a personal access token can be generated on user's specific page. Note that OctoKit uses AFNetworking 1.x, which is incompatible with TravisKit.

# Usage

To use TravisKit, we must first create a client and specify to which server we will connect to (open source or private).
After our client is initialized, we must authenticate to Travis with GitHub.

```
TKClient* client = [[TKClient alloc] initWithServer:TKOpenSourceServer];

[client authenticateWithGitHubToken:@"<GITHUB_TOKEN>" success:nil failure:nil;
```

After our client is authenticated, we can create requests for specific data:
```
[client recentRepositoriesWithSuccess:^(NSArray* repositories)
{
    // Do something with repositories here
}
failure:^(NSError* error)
{
    // Handle error
}];
```

See Demo project for more example calls and check out the header file for expressive documentation. [Travis CI API documentation](http://docs.travis-ci.com/api/) can also help.

# Submodules

TravisKit is divided into two submodules:
- Model contains all Travis CI models (`TravisKit/Model`) and routines to get them
- Log contains all functionality to stream build logs in realtime (`TravisKit/Log`)

You may use both or each of them separately.


Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [legoless@arvystate.net](mailto:legoless@arvystate.net)

License
======

TravisKit is available under the MIT license. See [LICENSE](https://github.com/Legoless/TravisKit/blob/master/LICENSE) file for more information.
