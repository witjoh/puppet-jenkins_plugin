#!/usr/bin/env python

import requests
import json

plugin_data = requests.get('https://updates.jenkins.io/stable/update-center.actual.json')
data = json.loads(plugin_data.content)

for i in data['plugins'].keys():
    name = data['plugins'][i]['name']
    version = data['plugins'][i]['version']
    print("jenkins_plugin::plugins::base::{}::version: '{}'".format(name.replace('-','_').lower(), version))
