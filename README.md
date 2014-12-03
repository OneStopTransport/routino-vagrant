routino-vagrant
===============

Vagrant machine for Routino ([routino.org](http://www.routino.org)) with OSM data from Portugal.


## Requirements

- **VirtualBox** - [https://www.virtualbox.org/](https://www.virtualbox.org/)
- **Vagrant** - [http://www.vagrantup.com/](http://www.vagrantup.com/)

---

### Setup

After installing the requirements (check their documentation for any issues or doubts) just run the following command:

```
vagrant up
```

IF you don't want to setup the Routino instance with data from Portugal, edit the `routino-setup/install.sh` file in order to comment the lines 18 and 19, with a \# in the beginning of the line, which consist of `sed` commands to replace the Great Britain OSM data with Portugal OSM data.

Everything is installed automatically and at the end you just need to head to the specified URL in your browser and use your freshly-installed Routino instance!

---

### Issues/Troubleshooting

Feel free to contact us or create a new issue on this repository.
We'll do our best to try and help!