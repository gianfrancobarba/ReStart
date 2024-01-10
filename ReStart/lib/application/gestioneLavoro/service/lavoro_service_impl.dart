import '../../../model/dao/annuncio_di_lavoro/annuncio_di_lavoro_DAO.dart';
import '../../../model/dao/annuncio_di_lavoro/annuncio_di_lavoro_DAO_impl.dart';
import '../../../model/dao/autenticazione/CA/ca_DAO.dart';
import '../../../model/dao/autenticazione/CA/ca_DAO_impl.dart';
import '../../../model/dao/autenticazione/utente/utente_DAO.dart';
import '../../../model/dao/autenticazione/utente/utente_DAO_impl.dart';
import '../../../model/dao/candidatura_lavoro/candidatura_DAO.dart';
import '../../../model/dao/candidatura_lavoro/candidatura_DAO_impl.dart';
import '../../../model/entity/annuncio_di_lavoro_DTO.dart';
import '../../../model/entity/candidatura_DTO.dart';
import '../../../model/entity/utente_DTO.dart';
import 'lavoro_service.dart';

class LavoroServiceImpl implements LavoroService{
  final AnnuncioDiLavoroDAO _lavoroDAO;
  final CaDAO _caDAO;
  final UtenteDAO _utenteDAO;

  LavoroServiceImpl()

      : _lavoroDAO = AnnuncioLavoroDAOImpl(),
        _caDAO = CaDAOImpl(),
        _utenteDAO = UtenteDAOImpl();

  AnnuncioDiLavoroDAO get lavoroDAO => _lavoroDAO;
  CaDAO get caDAO => _caDAO;
  UtenteDAO get utenteDAO => _utenteDAO;

  @override
  Future<bool> addLavoro(AnnuncioDiLavoroDTO annuncio) {
    return _lavoroDAO.add(annuncio);
  }

  @override
  Future<bool> approveLavoro(int  id_annuncio) async {
    if(await _lavoroDAO.existById(id_annuncio) == false){
      return false;
    }
    AnnuncioDiLavoroDTO? lavoro=await _lavoroDAO.findById(id_annuncio);
    lavoro?.approvato = true;
    return _lavoroDAO.update(lavoro);
  }

  @override
  Future<bool> deleteLavoro(int id) {
    return _lavoroDAO.removeById(id);
  }
/*
  @override
  Future<AnnuncioDiLavoroDTO?> detailsLavoro(int id) {
    return _lavoroDAO.findById(id);
  }*/

  @override
  Future<bool> modifyLavoro(AnnuncioDiLavoroDTO annuncio) {
    return _lavoroDAO.update(annuncio);
  }

  @override
  Future<List<AnnuncioDiLavoroDTO>> offerteLavoro() {
    return _lavoroDAO.findAll();
  }

  @override
  Future<List<AnnuncioDiLavoroDTO>> offertePubblicate(String usernameCA) {
    return _lavoroDAO.findByApprovato(usernameCA);
  }
/*
  @override
  Future<UtenteDTO?> profiloUtenteCandidato(UtenteDTO? u) async {
    return utenteDAO.findById(u?.id);
  }*/

  @override
  Future<bool> rejectLavoro(int id_annuncio) async {
    if(await _lavoroDAO.existById(id_annuncio) == false){
      return false;
    }
    return _lavoroDAO.removeById(id_annuncio);
  }

  /*@override
  Future<List<AnnuncioDiLavoroDTO>> richiestaLavoro() {
    // TODO: implement richiestaLavoro
    throw UnimplementedError();
  }*/

  @override
  Future<List<UtenteDTO?>?> utentiCandidati(AnnuncioDiLavoroDTO annuncio) async {
    CandidaturaDAO candidaturaDAO = CandidaturaDAOImpl();
    List<CandidaturaDTO> candidature = await candidaturaDAO.findAll();
    List<UtenteDTO?>? userCandidati = [];
    for(CandidaturaDTO c in candidature){
      if(c.id_lavoro == annuncio.id) {
        userCandidati.add(await utenteDAO.findById(c.id_utente));
      }
    }
    return userCandidati;
  }
}