# Notifire
Notifire is a minimal event notification system for GameMaker Studio 2.3 based on the pubsub pattern, that allows objects / instances to communicate efficiently through loosely coupled events.

## Features
- Decouples objects through event-driven communication
- Easy to use with a simple, minimal API
- Callbacks run in the context of the subscribed instances
- Define events however you prefer: strings, numbers, enums, ...

## Installation  
1. Download the [latest release](https://github.com/Homunculus84/Notifire/releases) or clone the repository
2. Import the yymps package or scripts into your GameMaker Studio project.

## Usage

### Subscribing to events
Instances can subscribe to any number of events. Events are just identifier strings or numbers (or enums), they do not require a specific format as long as you are consistent.

Suscribing requires passing in a callback function that should run when the event is emitted. The function runs in the context of the instance, and gets two parameters when it is called: event (the event name) and data (any value passed by the emitter to the event).

**Important:** Instances are required to unsuscribe to all their events whenever they are destroyed. The object cleanup event is perfect for this.

```gml
// Subscribe the current instance to a single event, and use the event data.
notifire_subscribe("player.damaged", function(_event, _data) {
  show_debug_message(string("Player health has been damaged by {0}", _data));
});

// Subscribe the current instance to multiple events with the same callback
notifire_subscribe(["player.checkpoint", "stage.cleared"], function() {
  show_debug_message("Saving the game...");
});
```

### Unsubscribing from events
Unsubscribing is required before an instance gets destroyed. You can easily unsubscribe from all events or just selected ones.

```gml
// Unsubscribe the current instance from a single event
notifire_unsubscribe("player.damaged");

// Unsibscribe the current instance from multiple events
notifire_unsubscribe(["player.checkpoint", "stage.cleared"]);

// Unsubscribe the current instance from all events it is subscribed to
notifire_unsubscribe();
```

### Emitting (broadcasting) events
Events can be broadcasted from anywhere. 

```gml
// Broadcast the player.damaged event and notify the amount of damage taken
notifire_emit("player.damaged", _damage);

// Broadcast a stage.cleared event, without passing any data
notifire_emit("stage.cleared");

// Broadcast an event with more structured data
notifire_emit("player.died", {killed_by: _enemy, x: x, y: y});
```
