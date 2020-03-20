const updateShow = (data) => {
  const wordSeekerPlayer = document.getElementById('word-grid-seeker-player');
  const wordSeeker = document.getElementById('word-grid-seeker-not-player');
  const wordSpy = document.getElementById('word-grid-spy');
  const lists = document.getElementById('lists');
  if (wordSeekerPlayer) {
    if (data.word.missed) {
      wordSeekerPlayer.innerHTML = data.seeker_not_player;
    } else {
      wordSeekerPlayer.innerHTML = data.seeker_player;
    }
  }
  if (wordSeeker) {
    if (data.word.missed) {
      wordSeeker.innerHTML = data.seeker_player;
    } else {
      wordSeeker.innerHTML = data.seeker_not_player;
    }
  }
  if (wordSpy) { wordSpy.innerHTML = data.spy; }
  if (lists) { lists.innerHTML = data.list; }
}

const initActionCable = () => {
  const wordSeekerPlayer = document.getElementById('word-grid-seeker-player');
  const wordSeeker = document.getElementById('word-grid-seeker-not-player');
  const wordSpy = document.getElementById('word-grid-spy');
  if (wordSpy) {
    const gameId = wordSpy.dataset.game;
    App[`game_${gameId}`] = App.cable.subscriptions.create(
    { channel: 'GamesChannel', game_id: gameId },
    { received: (data) => updateShow(data) }
    );
  } else if (wordSeeker) {
    const gameId = wordSeeker.dataset.game;
    App[`game_${gameId}`] = App.cable.subscriptions.create(
    { channel: 'GamesChannel', game_id: gameId },
    { received: (data) => updateShow(data) }
    );
  } else if (wordSeekerPlayer) {
    const gameId = wordSeekerPlayer.dataset.game;
    App[`game_${gameId}`] = App.cable.subscriptions.create(
    { channel: 'GamesChannel', game_id: gameId },
    { received: (data) => updateShow(data) }
    );
  }
}

export { initActionCable };
