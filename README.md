# SSRFuck
Fuzz for SSRF in a given URL.
The tool is fuzzing both in common SSRF GET parameters and in HTTP headers.

The tool comes with two predefined wordlists. Feel free to use as is, manipulate or contribute ;)

## Prerequisites
The tool is heavily based on [ffuf](https://github.com/ffuf/ffuf).

## Installation
Just clone the repo

```bash
git clone https://github.com/rotemreiss/ssrfuck.git
```

## Usage

Just run the script with two arguments:
- The URL to fuzz
- Your burp collaborator URL (without the schema)

Example:
```bash
./ssrfuck.sh https://www.hackerone.com xxxxxxx.burpcollaborator.net
```

Multiple URLs example with Bash one-liner:

```bash
while read url; do ./ssrfuck.sh $url xxxxxxx.burpcollaborator.net;done < urls_list.txt
```

### Found results in your Burp collaborator? Great!
The request information is in the subdomain, for example: `Base-Url-www.hackerone.com.xxxxx.burpcollaborator.net`.
Also, all the logs from ffuf are saved to the ffuf-output directory.

---

## Contribution
Pull requests are most welcome.

## TODO
- Add help/usage in the tool's CLI
- Add some error handling
- Add some options

---

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)